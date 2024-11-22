FROM archlinux:base-devel

RUN pacman --sync --refresh && \
    pacman --sync --noconfirm uv && \
    useradd --home-dir /home/test --create-home --groups wheel test && \
    mkdir -p /home/test/dev/dotfiles && \
    chown test:test /home/test/dev/dotfiles && \
    echo '%wheel ALL=(ALL:ALL) NOPASSWD: ALL' >/etc/sudoers.d/wheel

USER test
WORKDIR /home/test/dev/dotfiles
COPY --chown=test:test ansible.cfg hosts.yaml pyproject.toml roles/ setup.yaml uv.lock /home/test/dev/dotfiles/
RUN sed -ri 's/(become_ask_pass) = true/\1 = false/' ansible.cfg && \
    uv run ansible-playbook setup.yaml
ENTRYPOINT zsh
