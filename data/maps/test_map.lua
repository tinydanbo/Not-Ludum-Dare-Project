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
    },
    {
      name = "tile_tower_1",
      firstgid = 3,
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      image = "tile_tower_1.png",
      imagewidth = 160,
      imageheight = 384,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 240,
      tiles = {
        {
          id = 0,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 1,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 2,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 3,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 4,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 5,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 6,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 7,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 8,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 9,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 10,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 11,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 12,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 13,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 15,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 16,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 17,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 18,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 19,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 20,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 21,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 22,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 23,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 25,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 26,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 27,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 28,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 29,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 33,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 35,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 36,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 37,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 39,
          properties = {
            ["collidable"] = "true"
          }
        }
      }
    }
  },
  layers = {
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
    },
    {
      type = "tilelayer",
      name = "Copy of Tile Layer 1",
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
      data = "eJzllEsLwyAQhJe+6IM25xyaHNv//wtrwQEZdtZoDiV0YBDNru5n1IuZXTfuW/LZtq+T/SfHM3lasd4uuzYW5XuKOLz5X8nvxrVrc3772B9uVT7Pozg4Hp6zexgiDuwPt9CQzfWAFxxzo709aZ2jZZ0xm9cFLzjU/rf4FxxQea7K7ypeaWmsiqvlgkPFehxrz766iybGVG2lwKHuv3euPKn82t3hvCUcQ2Hm4PsfcXhW+RGHOXnMEdU8OmPM7HGUUu+bp+gsqf+B2qOaezl6/ofi4Dz078kPqpVrLMfUe+Vx7JMPG/cx+QOEVxXX"
    }
  }
}
