geth = import_module("github.com/kurtosis-tech/geth-package/lib/geth.star@gyani/new-address")
lighthouse = import_module("github.com/kurtosis-tech/lighthouse-package/lib/lighthouse.star@gyani/new-address")
mev_launcher = import_module("github.com/kurtosis-tech/mev-package/lib/mev_launcher.star")
transaction_spammer = import_module("github.com/kurtosis-tech/eth2-package/src/transaction_spammer/transaction_spammer.star@gyani/custom-txfuzz")

network_params = json.decode(read_file("github.com/kurtosis-tech/geth-lighthouse-mev-package/network_params.json"))
LAUNCH_MEV_FLOOD = True
SECONDS_PER_BUNDLE = 60

def run(plan):
    el_extra_params, mev_builder_image, validator_extra_params, beacon_extra_params = mev_launcher.get_mev_params()

    # Generate genesis, note EL and the CL needs the same timestamp to ensure that timestamp based forking works
    final_genesis_timestamp = geth.generate_genesis_timestamp()
    el_genesis_data = geth.generate_el_genesis_data(plan, final_genesis_timestamp, network_params)

    # Run the nodes
    el_context = geth.run(plan, network_params, el_genesis_data, mev_builder_image, el_extra_params)
    cl_context = lighthouse.run(plan, network_params, el_genesis_data, final_genesis_timestamp, el_context, beacon_extra_params, validator_extra_params)

    transaction_spammer.launch_transaction_spammer(plan, geth.genesis_constants.PRE_FUNDED_ACCOUNTS, el_context)

    # this fail with init as there's competition with the spammer; either move spammer down or fix this
    output = mev_launcher.launch_mev(plan, el_context, cl_context, network_params, LAUNCH_MEV_FLOOD, SECONDS_PER_BUNDLE)

    return output
