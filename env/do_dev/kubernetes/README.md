## Example

```tf
"0" = merge(local.default, {
  cluster_name = "k8s"
  record_name  = "k8s"
})
```
