package assets

func MustAssetString(name string) string {
	return string(MustAsset(name))
}
