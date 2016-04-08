Elasticsearch::Model.client = Elasticsearch::Client.new host: Figaro.env.elasticsearch_host,
                                                        log: true
