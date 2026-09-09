# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

**Fixed**

- `JSON.Encoder` implementation crashed on Elixir 1.19 and later. It called an
  internal Elixir module that no longer exists.

**Changed**

- Minimum supported Elixir version is now 1.16.

## v0.1.0 - 2024-12-26

Initial release.
