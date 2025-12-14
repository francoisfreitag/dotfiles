#!/usr/bin/env python

import configparser
import pathlib
import sys


def main(config):
    for section in config.sections():
        try:
            default = config[section]["Default"]
        except KeyError:
            pass
        else:
            if default.endswith(".dev-edition-default"):
                return default
    sys.exit("Could not find default firefox-dev-edition profile.")


if __name__ == "__main__":
    profiles_path = (
        pathlib.Path().home() / ".config" / "mozilla" / "firefox" / "profiles.ini"
    )
    config = configparser.ConfigParser()
    config.read(profiles_path)
    print(main(config))
