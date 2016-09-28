module AqumulateAPI
  class Transaction < Entity

    ATTR_MAP = {
        id: 'TransactionId',
        account_id: 'AccountId',
        transaction_type: 'TransactionType',
        posted_date: 'PostedDate',
        origination_date: 'OriginationDate',
        amount: 'Amount',
        currency: 'CurCode',
        description: 'Description',
        code: 'TransactionCode',
        action: 'TransactionAction',
        date: 'TransactionDate',
        commision: 'Commission',
        ticker: 'Ticker',
        position_description: 'PosDescription',
        asset_id: 'AssetID',
        asset_type: 'AssetIDType',
        units: 'Units',
        price: 'Price',
        check_number: 'CheckNumber',
        created_on: 'CreatedOn'
    }

    attr_accessor :id, :account_id, :transaction_type, :posted_date, :origination_date, :amount, :currency,
                  :description, :code, :action, :date, :commission, :ticker, :position_description, :asset_id,
                  :asset_type, :units, :price, :check_number, :created_on

    # @param advisor [Advisor]
    # @param account [Account]
    # @param start_date [Date]
    # @param end_date [Date]
    # @return [Array(Transaction)]
    def self.fetch(advisor, account, start_date, end_date)
      body = {
          'SessionId' => advisor.session_id,
          'AccountId' => account.id,
          'AccountType' => account.account_type,
          'ExtendedAccountType' => account.account_type_extended,
          'StartDate' => start_date.strftime('%m/%d/%Y'),
          'EndDate' => end_date.strftime('%m/%d/%Y')
      }

      response = AggAccount.advisor_get_transactions_by_date(body)

      return [] unless response.has_key?('Transactions')

      response['Transactions'].map { |source| from_source(source) }
    end

  end
end