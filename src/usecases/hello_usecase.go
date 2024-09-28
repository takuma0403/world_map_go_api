// src/usecases/hello_usecase.go
package usecases

type HelloUseCase struct{}

func NewHelloUseCase() *HelloUseCase {
	return &HelloUseCase{}
}

func (uc *HelloUseCase) GetHelloMessage() string {
	return "Hello World"
}
