#!/usr/bin/env python3

from jinja2 import Environment, FileSystemLoader
import os


def main():
    env = Environment(loader=FileSystemLoader('templates'))

    fq_db_properties_filename = os.environ["ORDS_CONF_DIR"] + "/db_params.properties"
    print("Generating " + fq_db_properties_filename)
    template = env.get_template('db_params.properties.j2')
    output_from_parsed_template = template.render({ 'db_host': os.environ["DB_HOST"],
                                                    'db_port': os.environ["DB_PORT"],
                                                    'db_sys_pw': os.environ["ORACLE_SYS_PASSWORD"],
                                                    'prometheus_schema': os.environ["PROMETHEUS_SCHEMA"],
                                                    'prometheus_pw': os.environ["PROMETHEUS_SCHEMA_PASSWORD"],

    })

    with open(fq_db_properties_filename, "w") as fh:
        fh.write(output_from_parsed_template)

    fq_ords_properties_filename = os.environ["ORDS_CONF_DIR"] + "/ords_params.properties"
    print("Generating " + fq_ords_properties_filename)
    template = env.get_template('ords_params.properties.j2')
    output_from_parsed_template = template.render({ 'db_host': os.environ["DB_HOST"],
                                                    'db_port': os.environ["DB_PORT"],
                                                    'db_sys_pw': os.environ["ORACLE_SYS_PASSWORD"],
                                                    'prometheus_schema': os.environ["PROMETHEUS_SCHEMA"],
                                                    'prometheus_pw': os.environ["PROMETHEUS_SCHEMA_PASSWORD"],

    })

    with open(fq_ords_properties_filename, "w") as fh:
        fh.write(output_from_parsed_template)


if __name__ == "__main__":
    main()
