import logging
from inspect import currentframe

import pandas as pd
from sqlalchemy import create_engine

logger = logging.getLogger(__name__)


class Satellite:
    def __init__(self, **kwargs) -> None:
        """
        kwargs:
            sat_schema (str): The schema of the SAT.
            sat_table (str): The table of the SAT.
            sat_raw_query (str): The raw query for the SAT.
            sat_conn_str (str): The connection string for the SAT database.
        """
        self.sat_schema = kwargs["sat_schema"]
        self.sat_table = kwargs["sat_table"]
        self.sat_raw_query = kwargs["sat_raw_query"]
        self.engine = create_engine(kwargs["sat_conn_str"])

    def _extract(self) -> pd.DataFrame:
        """Extract data for the SAT entity from the source"""
        frame = currentframe().f_code.co_name

        data = pd.read_sql(sql=self.sat_raw_query, con=self.engine)
        logger.info(f"{frame} → Data extracted: shape{data.shape}")

        return data

    def _load(self, data: pd.DataFrame) -> None:
        """Insert data to the target SAT entity"""
        frame = currentframe().f_code.co_name

        rows = data.to_sql(
            schema=self.sat_schema,
            name=self.sat_table,
            con=self.engine,
            index=False,
            if_exists="append",
        )

        logger.info(f"{frame} → Data loaded: shape({rows})")

    def update(self) -> None:
        """Run the sequence of update methods for the SAT entity"""
        frame = currentframe().f_code.co_name

        raw_data = self._extract()
        if raw_data.empty:
            logger.info(f"{frame} → NO DATA")
            return

        self._load(raw_data)


def sat_update(**kwargs):
    frame = currentframe().f_code.co_name
    logger.info(f"{frame} → START")

    sat = Satellite(**kwargs)
    sat.update()

    logger.info(f"{frame} → END")
