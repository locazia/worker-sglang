FROM lmsysorg/sglang:gemma4

RUN curl -Ls https://astral.sh/uv/install.sh | sh \
 && ln -sf /root/.local/bin/uv /usr/local/bin/uv

ENV PATH="/root/.local/bin:${PATH}"
ENV PYTHONUNBUFFERED=1
ENV HF_HUB_ENABLE_HF_TRANSFER=1

WORKDIR /sgl-workspace

COPY requirements.txt ./

RUN --mount=type=cache,target=/root/.cache/uv \
    UV_BREAK_SYSTEM_PACKAGES=1 uv pip install --system -r requirements.txt

COPY handler.py engine.py utils.py download_model.py test_input.json ./
COPY public/ ./public/

ENTRYPOINT []
CMD ["python3", "-u", "handler.py"]
