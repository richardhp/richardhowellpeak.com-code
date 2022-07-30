# Kind

To make life easier for local development, we are using the [kind tool](https://kind.sigs.k8s.io)

## Getting Started

In order to setup and test a local kubernetes cluster, install the kind CLI tool with asdf:

```bash
asdf plugin add kind
asdf install kind latest
asdf local kind latest
```

Now you are ready to create a small 3-node cluster as per the config in this directory:

```bash
kind create cluster --config kind-config.yaml
```
