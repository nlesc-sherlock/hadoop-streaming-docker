FROM python:2

COPY mapper.py /usr/bin/
COPY reducer.py /usr/bin/

RUN chmod +x /usr/bin/mapper.py /usr/bin/reducer.py
