import pytest

from main.app import create_app
from main.flask_settings import TestConfig


@pytest.yield_fixture(scope='function')
def app():
    return create_app(TestConfig)
