module LlPay
  module RefundOrder
    REFUND_ORDER_PARAMS = %w(oid_partner sign_type no_refund dt_refund money_refund no_order dt_order oid_paybill notify_url)
    def refund_order(params, options = {})
      LlPay::Utils.check_required_params(params, REFUND_ORDER_PARAMS)
      params = LlPay::Utils.stringify_keys(params)
      options = LlPay::Utils.stringify_keys(options)

      params[:sign_type] = params[:sign_type] || options[:sign_type] || LlPay.sign_type
      params[:oid_partner] = params[:oid_partner] || options[:oid_partner] || LlPay.oid_partner

      sign_params = { oid_partner: params[:oid_partner],
                      sign_type: params[:sign_type],
                      no_refund: params[:no_refund],
                      dt_refund: params[:dt_refund],
                      money_refund: params[:money_refund],
                      no_order: params[:no_order],
                      dt_order: params[:dt_order],
                      oid_paybill: params[:oid_paybill],
                      notify_url: params[:notify_url]
                    }

      params[:sign] = LlPay::Sign.generate(sign_params, options)

      request(:post, 'https://yintong.com.cn/traderapi/refund.htm', params, options)
    end

    REFUND_ORDER_QUERY_PARAMS = %w(oid_partner sign_type no_refund dt_refund oid_refundno)
    def refund_order_query(params, options = {})
      params = LlPay::Utils.stringify_keys(params)
      options = LlPay::Utils.stringify_keys(options)

      params[:sign_type] = params[:sign_type] || LlPay.sign_type
      params[:oid_partner] = LlPay.oid_partner

      sign_params = { oid_partner: params[:oid_partner],
                      sign_type: params[:sign_type],
                      no_refund: params[:no_refund],
                      dt_refund: params[:dt_refund],
                      oid_refundno: params[:oid_refundno]
                    }

      params[:sign] = LlPay::Sign.generate(sign_params, options)

      request(:post, 'https://queryapi.lianlianpay.com/refundquery.htm', params, options)
    end
  end
end
