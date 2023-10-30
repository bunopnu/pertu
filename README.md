## Pertu

Pertu (Personal Erlang-related Tooling Utility) is an user-level, source-first version manager designed to simplify the management of different versions of Erlang-related tools on Microsoft Windows.

## Features

- Pertu allows you to install, list, and manage different versions of tools like Rebar3 and ErlangLS.
- Pertu offers simple and intuitive commands for managing tools, making it easy to work with different versions.

## Disclaimer

I created Pertu for my personal use, and while it works well for me, there may be some bugs. If you encounter any issues, please create an issue on GitHub.

The codebase might not be the most elegant, as I'm not very proficient at scripting. There may be several areas where improvements can be made.

## Installation

To get started with Pertu, follow these steps:

1. Download the source code from GitHub.

2. Extract the `src/` folder to a directory of your choice.

3. Add the `src/` directory where you extracted Pertu to your system's environment path.

## Manager Requirements

Before using Pertu, ensure you have the following prerequisites installed for that manager:

- `rebar3`: Erlang/OTP
- `erlangls`: Erlang/OTP and Rebar3
- `erlperf`: Erlang/OTP and Rebar3
- `gleam`: Rust and Cargo
- `efmt`: Rust and Cargo

## Usage

### List All Available Versions

To list all available versions of a package, use the `list-all` action:

```powershell
pertu [manager] list-all
```

#### Example

```powershell
pertu erlangls list-all
```

```powershell
pertu rebar3 list-all
```

### Install by Version

To install a specific version of a package, use the `install` action:

```powershell
pertu [manager] install [version]
```

#### Example

```powershell
pertu rebar3 install 3.22.1
```

```powershell
pertu gleam install latest
```

### List Installed Versions

To list the installed versions of a package, use the `list` action:

```powershell
pertu [manager] list
```

#### Example

```powershell
pertu gleam list
```

```powershell
pertu efmt list
```

### Select Global Version

To set a global version of a package for your user, use the `global` action:

```powershell
pertu [manager] global [version]
```

#### Example(s)

```powershell
pertu erlangls global 0.48.1
```

```powershell
pertu rebar3 global latest
```

### Remove Specific Version

To remove a specific version of a package, use the `remove` action:

```powershell
pertu [manager] remove [version]
```

#### Example

```powershell
pertu erlperf remove latest
```

```powershell
pertu rebar3 remove 3.22.0
```

## License

Pertu is licensed under the 3-Clause BSD license.
