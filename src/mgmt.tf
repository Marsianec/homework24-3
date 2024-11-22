data "yandex_resourcemanager_folder" "terteryan" {
  name = "terteryan"
}

data "yandex_iam_service_account" "service-account" {
  name = "ter-test"
}