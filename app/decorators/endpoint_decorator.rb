class EndpointDecorator < SimpleDelegator
    def string_id
        self.id.to_s
    end
end