const ppTimelineConfig = {
  "durationMs": 2067,
  "effects": [
    {
      "name": "LumiChromaticAberration",
      "preset": "low",
      "parameterTimelines": {
        "intensity": {
          "defaultValue": 0.0,
          "segments": [
            {
              "start": 50,
              "end": 350,
              "from": 0.0,
              "to": 1.0,
              "easing": "customEasings.OutIn.Exponential"
            },
            {
              "start": 350,
              "end": 1400,
              "from": 1.0,
              "to": 1.0,
              "easing": "linear"
            },
            {
              "start": 1400,
              "end": 1750,
              "from": 1.0,
              "to": 0.0,
              "easing": "customEasings.OutIn.Exponential"
            },
            {
              "start": 1750,
              "end": 2017,
              "from": 0.0,
              "to": 0.0,
              "easing": "linear"
            }
          ]
        }
      },
      "id": "main_chromatic"
    },
    {
      "name": "LumiBCC_Prism",
      "preset": "medium",
      "parameterTimelines": {
        "intensity": {
          "defaultValue": 0.0,
          "segments": [
            {
              "start": 100,
              "end": 400,
              "from": 0.0,
              "to": 1.0,
              "easing": "customEasings.OutIn.Exponential"
            },
            {
              "start": 400,
              "end": 1500,
              "from": 1.0,
              "to": 1.0,
              "easing": "linear"
            },
            {
              "start": 1500,
              "end": 1850,
              "from": 1.0,
              "to": 0.0,
              "easing": "customEasings.OutIn.Exponential"
            },
            {
              "start": 1850,
              "end": 2017,
              "from": 0.0,
              "to": 0.0,
              "easing": "linear"
            }
          ]
        }
      },
      "id": "main_prism"
    }
  ]
};

exports.ppTimelineConfig = ppTimelineConfig;
