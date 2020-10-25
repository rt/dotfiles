package order

import (
	"context"
	"error"
)

// Service describes the Order service
type Service interface {
	Create(ctx context.Context, order Order) (string, error)
	GetByID(ctx context.Context, id string) (Order, error)
	ChangeStatus(ctx context.Context, id string, status string) error
}
