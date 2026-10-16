const ppTimelineConfig = {
  "durationMs": 2000,
  "effects": [
    {
      "name": "LumiPageTurn",
      "preset": "topRight",
      "parameterTimelines": {
        "intensity": {
          "defaultValue": 1.0,
          "segments": [
            {
              "start": 0,
              "end": 200,
              "from": 1.0,
              "to": 1.0,
              "easing": "linear"
            },
            {
              "start": 200,
              "end": 1000,
              "from": 1.0,
              "to": 0.0,
              "easing": "customEasings.UI.HoverBloom"
            },
            {
              "start": 1000,
              "end": 2000,
              "from": 0.0,
              "to": 0.0,
              "easing": "linear"
            }
          ]
        }
      },
      "id": "page_turn_main"
    },
    {
      "name": "LumiRoundCorner",
      "preset": "medium",
      "parameterTimelines": {
        "intensity": {
          "defaultValue": 0.72,
          "segments": [
            {
              "start": 0,
              "end": 267,
              "from": 0.72,
              "to": 0.72,
              "easing": "linear"
            },
            {
              "start": 267,
              "end": 933,
              "from": 0.72,
              "to": 0.0,
              "easing": "Exponential.Out"
            },
            {
              "start": 933,
              "end": 2000,
              "from": 0.0,
              "to": 0.0,
              "easing": "linear"
            }
          ]
        }
      },
      "id": "round_corner_main"
    }
  ]
};

exports.ppTimelineConfig = ppTimelineConfig;
