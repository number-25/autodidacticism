# Cheatsheet for manipulating JSON files, mostly using jq

## Update the value of a field

```jq
jq '.[] | .["somaticDnaFastqToMaf.testSampleCoverageGff"] = "yes"'  somaticDnaFastqToMaf.inputs
```

