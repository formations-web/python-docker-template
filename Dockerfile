FROM python:3.13-slim

ARG USER_UID=1000
ARG USER_GID=1000

RUN groupadd --gid ${USER_GID} dev \
    && useradd --uid ${USER_UID} --gid ${USER_GID} --create-home dev

USER dev
WORKDIR /home/dev/app

COPY --chown=dev:dev requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt

ENV PATH="/home/dev/.local/bin:${PATH}"

WORKDIR /workspace