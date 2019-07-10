FROM bitnami/postgresql:10.9.0
LABEL maintainer "hydrz <n.haoyuan@gmail.com>"

USER 0

ENV POSTGIS_VERSION=2.5.2

# Install postgis postgresql extension
RUN install_packages wget build-essential libxml2-dev libgeos-dev libproj-dev libgdal-dev \
    && cd /tmp \
    && wget "https://download.osgeo.org/postgis/source/postgis-${POSTGIS_VERSION}.tar.gz" \
    && export C_INCLUDE_PATH=/opt/bitnami/postgresql/include/:/opt/bitnami/common/include/ \
    && export LIBRARY_PATH=/opt/bitnami/postgresql/lib/:/opt/bitnami/common/lib/ \
    && export LD_LIBRARY_PATH=/opt/bitnami/postgresql/lib/:/opt/bitnami/common/lib/ \
    && tar zxf postgis-${POSTGIS_VERSION}.tar.gz && rm -f postgis-${POSTGIS_VERSION}.tar.gz \
    && cd postgis-${POSTGIS_VERSION} \
    && ./configure --with-pgconfig=/opt/bitnami/postgresql/bin/pg_config \
    && make \
    && make install \
    && apt-get remove --purge --auto-remove -y wget build-essential

USER 1001