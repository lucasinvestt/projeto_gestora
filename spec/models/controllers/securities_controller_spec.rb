require "rails_helper"

describe SecuritiesController, type: :controller do
    describe '#POST /securities' do
        context 'when all params are passed correctly' do
            it 'expect Security.count increase by 1' do
                expect do
                    post :create, format: :json, params: {
                        security: {
                            name: "PETR4",
                            security_type: "acao",
                            isin: "asbcdef"
                        }
                    }
                end.to change{ Security.count }.by 1
            end
        end

    end
end