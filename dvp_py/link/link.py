import logging
from inspect import currentframe

import pandas as pd
from sqlalchemy import create_engine

logger = logging.getLogger(__name__)


class Link:
    def __init__(self, **kwargs) -> None:
        """
        kwargs:
            link_schema (str): The schema of the LINK.
            link_table (str): The table of the LINK.
            link_raw_query (str): The raw query for the LINK.
            link_conn_str (str): The connection string for the LINK database.
        """
        self.link_schema = kwargs["link_schema"]
        self.link_table = kwargs["link_table"]
        self.link_raw_query = kwargs["link_raw_query"]
        self.engine = create_engine(kwargs["link_conn_str"])

    def _extract(self) -> pd.DataFrame:
        """Extract data for the LINK entity from the source"""
        frame = currentframe().f_code.co_name

        data = pd.read_sql(sql=self.link_raw_query, con=self.engine)
        logger.info(f"{frame} → Data extracted: shape{data.shape}")

        return data

    def _load(self, data: pd.DataFrame) -> None:
        """Insert data to the target LINK entity"""
        frame = currentframe().f_code.co_name

        rows = data.to_sql(
            schema=self.link_schema,
            name=self.link_table,
            con=self.engine,
            index=False,
            if_exists="append",
        )

        logger.info(f"{frame} → Data loaded: shape({rows})")

    def update(self) -> None:
        """Run the sequence of update methods for the LINK entity"""
        frame = currentframe().f_code.co_name

        raw_data = self._extract()
        if raw_data.empty:
            logger.info(f"{frame} → NO DATA")
            return

        self._load(raw_data)


def link_update(**kwargs):
    frame = currentframe().f_code.co_name
    logger.info(f"{frame} → START")

    link = Link(**kwargs)
    link.update()

    logger.info(f"{frame} → END")
