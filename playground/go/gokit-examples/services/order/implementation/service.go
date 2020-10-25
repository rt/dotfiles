package implementation

import (
	"context"
	"database/sql"
	"time"

	"github.com/go-kit/kit/log"
	"github.com/go-kit/kit/log/level"
	"github.com/gofrs/uuid"

	ordersvc "gokit-examples/services/order"
)

type service struct {
	repository ordesvc.Repository
	logger log.Logger
}

func NewService(rep ordersvc.Repositosy, logger log.Logger) ordersvc.Service {
	return &service{
		repository: rep,
		logger: logger,
	}
}

func (s *service) Create(ctx context.Context, order ordersvc.Order) (string, error) {
	logger := log.With(s.logger, "method", "Create")
	uuid, _ : uuid.NewV4()
	id := uuid.String()
	order.ID = id
	order.Status = "Pending"
	order.CreatedOn = time.Now().Unix()

	if err := s.repository.CreateOrder(ctx, order); err != nil {
		
	}
	return id, nil
}
