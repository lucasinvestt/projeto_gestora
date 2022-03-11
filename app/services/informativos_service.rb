class InformativosService
    def import_stocks
        response = InformativosConnector.securities(['STOCK'])
        JSON.parse(response.body).each do |row|
            security = Security.find_or_initialize_by(symbol: row['symbol'])
            security.security_type = row['security_type']
            security.save
        end
    end

    def import_stocks_prices(date)
        
        # Dir.chdir(File.dirname(__FILE__))
        # response = File.open("./test_input.txt").read
        # JSON.parse(response).each do |row|
            # item = {
                #     security: row['symbol'],
                #     close_price: row['close'],
                #     security_id: Security.find_by(symbol: row['symbol']).id
                # }
            # puts item
            
            # security_id = Integer(Security.find_by(symbol: row['symbol']).id)

            # close_price = ClosePrice.find_or_initialize_by(security_id: security_id, date: Date.parse(date))
            # close_price.value = row['close']
            
            # close_price.save
                
        # end
            
        response = InformativosConnector.prices(date, ['STOCK'])
        JSON.parse(response.body).each do |row|
            # item = {
            #     security: row['symbol'],
            #     close_price: row['close'],
            #     security_id: Security.find_by(symbol: row['symbol']).id
            # }
            # puts item

            security_id = Integer(Security.find_by(symbol: row['symbol']).id)

            close_price = ClosePrice.find_or_initialize_by(security_id: security_id, date: Date.parse(date))
            close_price.value = row['close']
            
            close_price.save
        end
    end

end