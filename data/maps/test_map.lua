return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.14.2",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 50,
  height = 15,
  tilewidth = 16,
  tileheight = 16,
  nextobjectid = 1,
  properties = {},
  tilesets = {
    {
      name = "test_tileset",
      firstgid = 1,
      filename = "test_tileset.tsx",
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      image = "test_tileset.png",
      imagewidth = 32,
      imageheight = 16,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 2,
      tiles = {
        {
          id = 0,
          properties = {
            ["collidable"] = "true"
          }
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "Tile Layer 1",
      x = 0,
      y = 0,
      width = 50,
      height = 15,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eJzllFEOwCAIQ9H7H3o/W2IaWhBNljmS/iggD5VmZu0Qfd3+yrHK3W9FayreM1WXl//xnzk7ytkt/947COuK/B+NHBWrcmD/sJ6qVE92yuvfeK6qq6o3OLCHBvvMn1nWl/lFsVhntF/9vxjPcq1ysP8c3Rf6RfkxF8ZlONQ/n+FQb3+Gw5w4NRsya8jscYyW5fB81VxXM2EXR+U+GAebM2o2mePD8jCOE3QB5j4CLg=="
    }
  }
}
