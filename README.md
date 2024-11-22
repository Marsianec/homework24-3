# Домашнее задание к занятию «Безопасность в облачных провайдерах» - Тертерян Вячеслав

---

### Задание 1  

С помощью ключа в KMS необходимо зашифровать содержимое бакета  

1. Создать ключ в KMS  
```
resource "yandex_kms_symmetric_key" "s3-key" {
  name              = "s3-symetric-key"
  description       = "test"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" 
}
```  

2. С помощью ключа зашифровать содержимое бакета, созданного ранее  
```
resource "yandex_storage_bucket" "ter-s3" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket = "ter-s3"
  depends_on = [ yandex_iam_service_account_static_access_key.sa-static-key ]

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.s3-key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }

  anonymous_access_flags {
    read = true
    list = false
    config_read = true
  }
  
}
```  

![alt text](https://github.com/Marsianec/homework24-3/blob/main/img/1.png) 


---

### Задание 2  

Создать статический сайт в Object Storage c собственным публичным адресом и сделать доступным по HTTPS  

1. Создать сертификат  

![alt text](https://github.com/Marsianec/homework24-3/blob/main/img/2.png)  

2. Создать статическую страницу в Object Storage и применить сертификат HTTPS  

![alt text](https://github.com/Marsianec/homework24-3/blob/main/img/3.png)  