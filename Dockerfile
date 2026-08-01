ARG PLONE_VERSION=6.0.15
FROM plone/plone-backend:${PLONE_VERSION}
ARG PLONE_VERSION
# PLONE_LINE sceglie quale docker/constraintsXX.cfg usare: 60, 61 oppure 62
ARG PLONE_LINE=60

COPY docker/create-constraints.py docker/requirements.txt /app/
# la struttura del repo viene replicata in /dist così i path relativi dentro
# constraintsXX.cfg (../ploneXX.cfg -> versions/*.cfg) risolvono come sull'host
COPY versions.cfg plone60.cfg plone61.cfg plone62.cfg /dist/
COPY versions/ /dist/versions/
COPY docker/constraints60.cfg docker/constraints61.cfg docker/constraints62.cfg /dist/docker/

RUN pip install -r https://dist.plone.org/release/${PLONE_VERSION}/requirements.txt ${PIP_PARAMS} && \
    python /app/create-constraints.py /dist/docker/constraints${PLONE_LINE}.cfg /app/constraints.txt && \
    ./bin/pip install --ignore-requires-python -r requirements.txt -c constraints.txt ${PIP_PARAMS} && \
    find /app/lib -name LC_MESSAGES -exec chown -R plone:plone {} \;
