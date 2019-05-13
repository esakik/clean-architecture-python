# Chapter 3 - Error management

## 原文
### Introduction
In every software project, a great part of the code is dedicated to error management, and this code has to be rock solid. Error management is a complex topic, and there is always a corner case that we left out, or a condition that we supposed could never fail, while it does.
In a clean architecture, the main process is the creation of use cases and their execution. This is therefore the main source of errors, and the use cases layer is where we have to implement the error management. Errors can obviously come from the domain models layer, but since those models are created by the use cases the errors that are not managed by the models themselves automatically become errors of the use cases.
To start working on possible errors and understand how to manage them, I will expand the RoomListUseCase to support filters that can be used to select a subset of the Room objects in the storage.
The filters argument could be for example a dictionary that contains attributes of the Room model and the thresholds to apply to them. Once we accept such a rich structure, we open our use case to all sorts of errors: attributes that do not exist in the Room model, thresholds of the wrong type, filters that make the storage layer crash, and so on. All these considerations have to be taken into account by the use case.
In particular we can divide the error management code in two different areas. The first one represents and manages requests, that is the input data that reaches our use case. The second one covers the way we return results from the use case through responses, the output data. These two concepts shouldn’t be confused with HTTP requests and responses, even though there are similarities. We are considering here the way data can be passed to and received from use cases, and how to manage errors. This has nothing to do with a possible use of this architecture to expose an HTTP API.
Request and response objects are an important part of a clean architecture, as they transport call parameters, inputs and results from outside the application into the use cases layer.
More specifically, requests are objects created from incoming API calls, thus they shall deal with things like incorrect values, missing parameters, wrong formats, and so on. Responses, on the other hand, have to contain the actual results of the API calls, but shall also be able to represent error cases and to deliver rich information on what happened.
The actual implementation of request and response objects is completely free, the clean architecture says nothing about them. The decision on how to pack and represent data is up to us.

### Basic requests and responses
We can implement structured requests before we expand the use case to accept filters. We just need a RoomListRequestObject that can be initialised without parameters, so let us create the file tests/request_objects/test_room_list_request_objects.py and put there a test for this object.

```
from rentomatic.request_objects import room_list_request_object as req


def test_build_room_list_request_object_without_parameters(): 
    request = req.RoomListRequestObject()
    assert bool(request) is True
    
    
def test_build_room_list_request_object_from_empty_dict(): 
    request = req.RoomListRequestObject.from_dict({})
    assert bool(request) is True
```

While at the moment this request object is basically empty, it will come in handy as soon as we start having parameters for the list use case. The code of the RoomListRequestObject is the following and goes into the rentomatic/request_objects/room_list_request_object.py file

```
class RoomListRequestObject: 
    @classmethod
    def from_dict(cls, adict): 
        return cls()
        
        
    def __bool__(self): 
        return True
```

The response object is also very simple, since for the moment we just need to return a successful result. Unlike the request, the response is not linked to any particular use case, so the test file can be named tests/response_objects/test_response_objects.py

```
from rentomatic.response_objects import response_objects as res


def test_response_success_is_true():
    assert bool(res.ResponseSuccess()) is True
```

and the actual response object is in the file rentomatic/response_objects/response_objects.py

```
class ResponseSuccess:
    def __init__(self, value=None): 
        self.value = value


    def __bool__(self): 
        return True
```

With these two object we just laid the foundations for a richer management of input and outputs of the use case, especially in the case of error conditions.

### Requests and responses in a use case



