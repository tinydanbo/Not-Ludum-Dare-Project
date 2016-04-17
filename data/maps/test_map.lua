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
  nextobjectid = 15,
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
            ["collidable"] = "true",
            ["tag"] = "world"
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
    },
    {
      type = "objectgroup",
      name = "Entities",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      objects = {
        {
          id = 1,
          name = "spinner",
          type = "spinner",
          shape = "rectangle",
          x = 304,
          y = 80,
          width = 208,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "spinner",
          type = "spinner",
          shape = "rectangle",
          x = 32,
          y = 80,
          width = 128,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "spinner",
          type = "spinner",
          shape = "rectangle",
          x = 192,
          y = 208,
          width = 160,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "lantern",
          type = "lantern",
          shape = "rectangle",
          x = 560,
          y = 16,
          width = 32,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "lantern",
          type = "lantern",
          shape = "rectangle",
          x = 544,
          y = 176,
          width = 32,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "lantern",
          type = "lantern",
          shape = "rectangle",
          x = 32,
          y = 144,
          width = 48,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "junk",
          type = "junk",
          shape = "rectangle",
          x = 368,
          y = 128,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "junk",
          type = "junk",
          shape = "rectangle",
          x = 592,
          y = 128,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "junk",
          type = "junk",
          shape = "rectangle",
          x = 624,
          y = 80,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "junk",
          type = "junk",
          shape = "rectangle",
          x = 752,
          y = 144,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "junk",
          type = "junk",
          shape = "rectangle",
          x = 720,
          y = 144,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "junk",
          type = "junk",
          shape = "rectangle",
          x = 176,
          y = 16,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
