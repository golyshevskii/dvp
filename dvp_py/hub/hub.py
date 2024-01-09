import logging
from inspect import currentframe

import pandas as pd
from sqlalchemy import create_engine

logger = logging.getLogger(__name__)


class Hub:
    def __init__(self, **kwargs) -> None:
        """
        kwargs:
            hub_schema (str): The schema of the HUB.
            hub_table (str): The table of the HUB.
            hub_raw_query (str): The raw query for the HUB.
            hub_conn_str (str): The connection string for the HUB database.
        """
        self.hub_schema = kwargs["hub_schema"]
        self.hub_table = kwargs["hub_table"]
        self.hub_raw_query = kwargs["hub_raw_query"]
        self.engine = create_engine(kwargs["hub_conn_str"])

    def _extract(self) -> pd.DataFrame:
        """Extract data for the HUB entity from the source"""
        frame = currentframe().f_code.co_name

        data = pd.read_sql(sql=self.hub_raw_query, con=self.engine)
        logger.info(f"{frame} → Data extracted: shape{data.shape}")

        return data

    def _load(self, data: pd.DataFrame) -> None:
        """Insert data to the target HUB entity"""
        frame = currentframe().f_code.co_name

        rows = data.to_sql(
            schema=self.hub_schema,
            name=self.hub_table,
            con=self.engine,
            index=False,
            if_exists="append",
        )

        logger.info(f"{frame} → Data loaded: shape({rows})")

    def update(self) -> None:
        """Run the sequence of update methods for the HUB entity"""
        frame = currentframe().f_code.co_name

        raw_data = self._extract()
        if raw_data.empty:
            logger.info(f"{frame} → NO DATA")
            return

        self._load(raw_data)


def hub_update(**kwargs):
    frame = currentframe().f_code.co_name
    logger.info(f"{frame} → START")

    hub = Hub(**kwargs)
    hub.update()

    logger.info(f"{frame} → END")
