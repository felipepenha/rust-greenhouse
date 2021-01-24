![](/images/Greenhouse_github_card.png)


# Greenhouse

A containerized Rust framework for a better Data X development workflow. Where X = Science, Engineering, Analytics, etc.


The name "Greenhouse" is a metaphor. A greenhouse is a structure made of glass to grow plants despite of external conditions such as a cold winter. Likewise, the Greenhouse framework builds a standalone container for Rust developmet which is fully transparent to the user.


# Quick Start

This is a template repository. [Follow this link for instructions to create a repository from a template](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/creating-a-repository-from-a-template#creating-a-repository-from-a-template).


First, make sure `make`, `docker` and `docker-compose` are installed in your system.


The greenhouse dev workf is performed via `make` commands.


To see the most up to date list of available commands run

```bash
$ make help

USAGE

    make <command>
    Include 'sudo' when necessary.


COMMANDS

    build:           build image using cache
    build-no-cache:  build image from scratch, and not from cache
    bash:            bash REPL (Read-Eval-Print loop), suitable for debugging
    rust:            access rust through the Evcxr REPL (Read-Eval-Print loop)
    rust-jupyter:    access rust through the Evcxr Jupyter Notebook
```


To build your greenhouse (as it is), you first need to run:

```bash
$ make build-no-cache
```


To access Jupyter in your local browser:

```bash
$ make rust-jupyter

Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
    
    To access the notebook, open this file in a browser:
        file:///root/.local/share/jupyter/runtime/nbserver-1-open.html
    Or copy and paste one of these URLs:
        http://(xxxxxxxxxxxx or 127.0.0.1):8888/?token=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```


Next, you simply need to follow the instructions printed out on your own terminal.


In the generic example above, I would paste the following on my browser:

```bash
http://127.0.0.1:8888/?token=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```


Any changes made in the files within the Jupyter interface, for example saved changes in `.rs`, `.ipynb`, and `.py` files, will be reflected in the original files you store locally, and vice-versa. This is ensured by the fact that the whole greenhouse directory is set as a `volume` in the `docker-compose.yml` configuration file.


You may also choose to run code using the REPL (Read-Eval-Print loop) in the terminal by running:

```bash
$ make rust
```


Now, you are ready to start developing Rust code by creating new `.rs` files in the `/src` directory.


During development phase, you can normally test out new code in a Jupyter Notebook, as you would do with Python.


For example, in the file `src/messages.rs` we have a public function defined as

```rust
pub fn hello_world() {
    println!("Hello, world! From `src/message.rs`");
}
```


In the Jupyter Notebook you will be able to access it through

```rust
>> #[path = "/usr/app/src/messages.rs"] mod messages;
>> use messages::hello_world;
```


Next, to actually use the function:

```rust
>> messages::hello_world();

Hello, world! From `src/message.rs`
```


Check out additional examples in the `/notebooks` directory (`.ipynb` files with preffix `example_`).


# Greenhouse Structure

```bash
.
├── Cargo.lock
├── Cargo.toml
├── docker-compose.yml
├── Dockerfile
├── LICENSE
├── Makefile
├── notebooks
│   ├── example_datafusion.ipynb
│   └── example_messages.ipynb
├── README.md
├── rust-toolchain.toml
├── src
│   ├── lib.rs
│   ├── main.rs
│   └── messages.rs
└── target
```


* `Cargo.toml`: manifest of the package. Dependencies are defined here.
* `src/`: source directory for your Rust package
* `src/lib.rs`: defines your package (ex: which crates are included)
* `src/main.rs`: a script for dev purposes with `$cargo run`
* `messages.rs`: example of crate that yields a "Hello World" message


# Adding External Dependencies

You need to include any external dependencies to the `Cargo.toml` file in addition to the default list:

```toml
[dependencies]
datafusion = "2.0.0"
arrow = "2.0.0"
```


You may also want to change a few lines in the `Dockerfile` to ensure that the correct version of Rust, consistent with your dependencies, is being used. We keep it fixed in the original Greenhouse template at `nightly-2021-01-01`:

```dockerfile
RUN rustup install nightly-2021-01-01
RUN rustup override set nightly-2021-01-01
RUN rustup run nightly rustc --version
```


`$ make build` will print out on your screen the version that is being used, in your own greenhouse. You may want to double-check it by running:

```bash
$ make bash
$ rustup run nightly rustc --version

Default host: x86_64-unknown-linux-gnu
rustup home:  /usr/local/rustup

installed toolchains
--------------------

nightly-2021-01-01-x86_64-unknown-linux-gnu
1.49.0-x86_64-unknown-linux-gnu (default)

active toolchain
----------------

nightly-2021-01-01-x86_64-unknown-linux-gnu (directory override for '/usr/app')
rustc 1.51.0-nightly (44e3daf5e 2020-12-31)
```


The above output means that, in fact, `nightly-2021-01-01` is being used for `/usr/app`.


## Continuous Integration

Follow the instructins in [CONTRIBUTING.md](https://github.com/felipepenha/rust-greenhouse/blob/main/CONTRIBUTING.md). Be sure to update `Cargo.toml` before each new release on the `dev` branch.





