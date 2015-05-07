FROM python:2.7-wheezy

RUN pip install uwsgi

COPY uwsgi.ini /www/fastrouter/

# Default Command
CMD ["uwsgi", "/www/fastrouter/uwsgi.ini"]

# Expose ports.
#   - 80: External HTTP
#   - 8000: Internal HTTP
EXPOSE 80
EXPOSE 8000
