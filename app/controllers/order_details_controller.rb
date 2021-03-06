class OrderDetailsController < ApplicationController

    def index
        @buyer_id = session[:customer_id]
        @shopping_cart = Product.joins(:orders).where("orders.customer_id = #{@buyer_id} AND orders.payment_method_id ISNULL").select('order_details.id AS order_details_id, products.id, products.product_name, products.product_price, products.product_desc, products.product_location, count(*) as quantity').group(:product_name)
        @can_buy = true
        @cart_total = Product.joins(:orders).where("orders.customer_id = #{@buyer_id} AND orders.payment_method_id ISNULL").select('ROUND(SUM(products.product_price), 2) AS grand_total')
    end

    def create
        @order_detail = OrderDetail.new(order_detail_params)
        @order_detail.order_id = session[:order_id]
        @order_detail.save
        redirect_back fallback_location: order_details_path
    end

    def complete_order
        @shopping_cart = Product.joins(:orders).where("orders.customer_id = #{session[:customer_id]} AND orders.payment_method_id ISNULL").select('order_details.id AS order_details_id, products.id, products.product_name, products.product_price, count(*) as quantity').group(:product_name)
    end

    def destroy
        @order_detail = OrderDetail.find(params[:id])
        @order_detail.destroy

        redirect_to order_details_path
    end

    def clear_cart
      @order_id = session[:order_id]
      OrderDetail.where("order_id = #{@order_id}").delete_all

      redirect_to order_details_path
    end

    private
        def order_detail_params
            params.permit(:product_id)
        end


        #params.require(:order_detail).permit(:product_id)
end
