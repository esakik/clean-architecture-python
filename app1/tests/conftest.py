import pytest

from src.app import create_app
from src.flask_settings import TestConfig


@pytest.yield_fixture(scope='function')
def app():
    return create_app(TestConfig)
