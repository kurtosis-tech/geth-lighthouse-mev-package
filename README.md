geth-lighthouse-mev-package
===========================

This is a [Kurtosis package](https://docs.kurtosis.com/concepts-reference/packages).

This package illustrates how with Kurtosis you can spin up a geth node, a light house node 
and add MEV components using individual packages. This is to illustrate how composing
Kurtosis packages is like putting together lego blocks.

This package is spinning up `mock` MEV by default which consists of MEV Boost and the Ethereum
Foundation mock mev builder. To launch `full` mev instead you can tweak `line 9` in `main.star`
and change it to `full`.

Run this package
----------------
If you have [Kurtosis installed][install-kurtosis], run:

<!-- TODO replace YOURUSER and THISREPO with the correct values -->
```bash
kurtosis run github.com/kurtosis-tech/geth-lighthouse-mev-package
```

If you don't have Kurtosis installed, [click here to run this package on the Kurtosis playground](https://gitpod.io/?autoStart=true&editor=code#https://github.com/kurtosis-tech/geth-lighthouse-package).

To blow away the created [enclave][enclaves-reference], run `kurtosis clean -a`.

#### Configuration

<details>
    <summary>Click to see configuration</summary>

You can configure this package using the JSON structure found in `network_params.json`. 

Use this package in your package
--------------------------------
Kurtosis packages can be composed inside other Kurtosis packages. To use this package in your package:

<!-- TODO Replace YOURUSER and THISREPO with the correct values! -->
First, import this package by adding the following to the top of your Starlark file:

```python
this_package = import_module("github.com/kurtosis-tech/geth-lighthouse-mev-package/main.star")
```

Then, call the this package's `run` function somewhere in your Starlark script:

```python
this_package_output = this_package.run(plan, args)
```

Develop on this package
-----------------------
1. [Install Kurtosis][install-kurtosis]
1. Clone this repo
1. For your dev loop, run `kurtosis clean -a && kurtosis run .` inside the repo directory


<!-------------------------------- LINKS ------------------------------->
[install-kurtosis]: https://docs.kurtosis.com/install
[enclaves-reference]: https://docs.kurtosis.com/concepts-reference/enclaves
