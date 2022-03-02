FROM python:3.8

# System deps:
RUN apt-get update \
  && apt-get install --no-install-recommends -y \
    bash \
    build-essential \
    curl \
    gettext \
    git \
    libpq-dev \
    wget \
  # Cleaning cache:
  && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* \
  && pip install poetry && poetry --version

RUN mkdir -p /usr/src/src
WORKDIR /usr/src/src

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

COPY pyproject.toml /usr/src/src/pyproject.toml
COPY poetry.lock /usr/src/src/poetry.lock

RUN ln -s ~/.poetry/bin/poetry /usr/bin/poetry

RUN poetry install

COPY . /usr/src/src

ENTRYPOINT [ "sh", "docker-entrypoint.sh" ]
