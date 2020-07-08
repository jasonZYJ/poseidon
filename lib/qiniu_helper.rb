module QiniuHelper
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attachment_params(path, private=true)
      {
          storage: :qiniu,
          qiniu_host: storage_host,
          qiniu_credentials: {
              access_key: 'aAhGAfthLN9s3_QAMan4ru7oj2GyomqbmbNTw_r_',
              secret_key: 'UqrgVCABVW8YyD4XwY_OF8Eygtn1aCmduw3dcQXb'
          },
          :bucket => bucket,
          :path => path
      }
    end

    def bucket(private=true)
      'poseidondev'
    end

    def storage_host
      'http://7xsgmr.com1.z0.glb.clouddn.com'
    end
  end

  def mime_type(path)
    ::Mime::Type.lookup_by_extension(::File.extname(path).split('.').last) || ::Mime::Type.lookup_by_extension('txt')
  end

  def qiniu_read(path)
    qiniu_object(path).read
  end

  def qiniu_object_url(path)
    primitive_url = "#{self.class.storage_host}/#{path}"
    Qiniu::Auth.authorize_download_url(primitive_url)
  end

end
