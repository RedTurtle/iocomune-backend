FROM plone/plone-backend:6.1.1
COPY docker/create-constraints.py docker/constraints.cfg docker/requirements.txt /app/
COPY versions.cfg /
RUN pip install -r https://dist.plone.org/release/6.1.1/requirements.txt ${PIP_PARAMS} && \
    python create-constraints.py constraints.cfg constraints.txt && \
    ./bin/pip install --ignore-requires-python -r requirements.txt -c constraints.txt ${PIP_PARAMS} && \
    find /app/lib -name LC_MESSAGES -exec chown -R plone:plone {} \;
