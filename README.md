# CrossmintTest
This is the iOS app created for the Crossming coding challenge.
It follows an MVVM pattern for the UI organization, it uses ReactiveSwift for bindings, and DifferenceKit for collection difference calculations.
It also has Alamofire for a better organization of the multiple endpoints used in the coding challenge.
The classes that model the domain are the following are depicted in the following UML diagram:
![image](https://github.com/user-attachments/assets/f9f5a64e-7356-4643-a31e-c19928fc83e2)
Polyanet, Soloon and Cometh implement the MegaverseObject prototol, so we can know their type using the Liskov Principle.
Next, we can see how we have used the MVVM pattern for a better organization of the UI code. We can also find here the MegaverseMapFactory, which is responsible for implementing the logic of the coding challenge.
While executing the logic, I realized that if we made all the POST operations at once, some of them where not being executed, despite of receiving a 200 OK. So I ended up adding 1 second delay after each API call.
![image](https://github.com/user-attachments/assets/9b006a9e-ff9e-4487-b964-99ae3ae34419)
And finally, here we can see the Data layer implementation. The entry point is the DataManager, which depends on a RemoteDataManager protocol. We have added an Alamofire based implementation of the protocol, but it can be exchanged with any other implementation if required.
![image](https://github.com/user-attachments/assets/c7e7c99f-cc21-4564-929f-f74b70373d1a)

