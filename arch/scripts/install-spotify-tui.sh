#!/usr/bin/env bash

if pacman -Qi rustup > /dev/null; then
	echo Rustup already installed
	rustup update
else
	echo Installing rustup
	rustup toolchain install stable
fi

cargo install spotify_player --no-default-features --features pulseaudio-backend,streaming,media-control
