Social Networks
==========

This document provides a basic overview of the implementation done for the test project.

Dependencies
----------
Rails => 5.2.8
Ruby => 2.5.1

Process
----------

Run the rails server and hit localhost:3000. A JSON response will be returned in minimal time.

Implementation
----------

The implementation involves multi-threading, so the total response time for the request would
be the maximum of three requests sent to the three given URLs. For requests, I have used
HTTParty gem.

I have also added exception handling and used recursion so that in case of any exception or
failed response we will try to hit again for that particular URL.
Also, I have rubocop configured and offenses have been resolved.

Testing
----------

I have user RSpec for unit testing and stubbed the three requests using webmock. So I have
created some possible responses and used those to write the specs.
