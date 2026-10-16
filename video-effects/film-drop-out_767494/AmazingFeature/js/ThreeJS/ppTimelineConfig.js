const ppTimelineConfig = {
  "durationMs": 2000,
  "effects": [
    {
      "name": "LumiFlicker",
      "preset": "low",
      "parameterTimelines": {
        "intensity": {
          "defaultValue": 0.0,
          "segments": [
            {
              "start": 50,
              "end": 470,
              "from": 0.0,
              "to": 0.0,
              "easing": "linear"
            },
            {
              "start": 470,
              "end": 800,
              "from": 0.0,
              "to": 0.12,
              "easing": "customEasings.Pulse.Cinematic.Single"
            },
            {
              "start": 800,
              "end": 870,
              "from": 0.0,
              "to": 0.0,
              "easing": "linear"
            },
            {
              "start": 870,
              "end": 1270,
              "from": 0.0,
              "to": 0.18,
              "easing": "customEasings.Pulse.Cinematic.Single"
            },
            {
              "start": 1270,
              "end": 1330,
              "from": 0.0,
              "to": 0.0,
              "easing": "linear"
            },
            {
              "start": 1330,
              "end": 1670,
              "from": 0.0,
              "to": 0.22,
              "easing": "Exponential.InOut"
            },
            {
              "start": 1670,
              "end": 1950,
              "from": 0.22,
              "to": 0.22,
              "easing": "linear"
            }
          ]
        }
      },
      "id": "film_gate_flicker_main"
    }
  ]
};

exports.ppTimelineConfig = ppTimelineConfig;
