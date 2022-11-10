FROM plone/plone-backend:5.2.9
COPY constraints.txt requirements.txt /app/
RUN ./bin/pip install --ignore-requires-python -r requirements.txt -c constraints.txt ${PIP_PARAMS} \
    find /app/lib -name LC_MESSAGES -exec chown -R plone:plone {} \;
