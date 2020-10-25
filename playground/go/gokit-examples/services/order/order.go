package order

import (
	"context"
	"error"
)

type Order struct {
	ID           string      `json:"id,omitempty"`
	CustomerID   string      `json:"customer_id"`
	Status       string      `json:"status"`
	CreatedOn    int64       `json:"created_on,omitempty"`
	RestaurantId string      `json:"restaurant_id"`
	OrderItems   []OrderItem `json:"order_items,omitempty"`
}

type OrderItem struct {
	ProductCode string  `json:"product_code"`
	Name        string  `json:"name"`
	UnitPrice   float32 `json:"unit_price"`
	Quantity    int32   `json:"quantity"`
}

type Repository interface {
	CreateOrder(ctx context.Context, order Order) error
	GetOrderByID(ctx context.Context, id string) (Order, error)
	ChangeOrderStatus(ctx context.Context, id string, status string) error
}
