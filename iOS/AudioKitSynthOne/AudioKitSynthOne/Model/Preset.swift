//
//  Preset.swift
//  AudioKit Synth One
//
//  Created by Matthew Fecher on 7/23/16.
//  Copyright © 2016 AudioKit. All rights reserved.
//

import Foundation


// ******************************************************
// MARK: - Preset
// ******************************************************

class Preset: Codable {
    
    var uid = UUID().uuidString
    var position = 0 // Preset #
    var name = "Init"
    
    // Synth VC
    var octavePosition = 0
    var isMono = 0.0
    var isHoldMode = 0.0
    var isArpMode = 0.0
    var isTempoSyncd = 0.0
    
    // Controls VC
    var masterVolume = 0.5 // Master Volume
    
    // Seq Pattern
    var seqPatternNote = [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var seqNoteOn = [true, true, true, true,true, true, true, true,true, true, true, true,true, true, true, true]
   
    var vco1Volume = 0.6
    var vco2Volume = 0.6
    var vco1Semitone = 0.0 // VCO1 Semitones
    var vco2Semitone = 0.0 // VCO2 Semitones
    var vco2Detuning = 0.0 // VCO2 Detune (Hz)
    var vcoBalance = 0.5 // VCO1/VCO2 Mix
    var subVolume = 0.0 // SubOsc Mix
    var fmVolume = 0.0 // FM Mix
    var fmMod = 0.0 // FM Modulation Amt
    var noiseVolume = 0.0 // Noise Mix
 
    var cutoff = 2000.0 // Cutoff Knob Position
    var rez = 0.1 // Filter Q/Rez
    var delayTime = 0.5 // Delay (seconds)
    var delayMix = 0.5 // Dry/Wet
    var delayFeedback = 0.1
    var reverbFeedback = 0.5 // Amt
    var reverbMix = 0.5 // Dry/Wet
    var reverbHighPass = 10.0 // Highpass filter freq for Filter
    var midiBendRange = 2.0 // MIDI bend range in +/- semitones
    var crushFreq = 44000.0 // Crusher Frequency
    var autoPanRate = 2.0 // AutoPan Rate
    var filterADSRMix = 0.0 // Filter Envelope depth
    var glide = 0.0 // Mono glide amount
    
    // ADSR
    var attackDuration = 0.05
    var decayDuration = 0.05
    var sustainLevel = 0.8
    var releaseDuration = 0.05
    
    var filterAttack = 0.05
    var filterDecay = 0.5
    var filterSustain = 1.0
    var filterRelease = 0.5
    
    // Toggle Presets
    var delayToggled = 0.0
    var reverbToggled = 1.0
    var autoPanToggled = 0.0
    var subOsc24Toggled = 0.0
    var subOscSquareToggled = 0.0
    
    // Waveforms
    var waveform1 = 0.0
    var waveform2 = 0.0
    
    var lfoWaveform = 0.0 // LFO wave index
    var lfoAmplitude = 0.0 // LFO Amp (Hz)
    var lfoRate = 0.0 // LFO Rate
    var lfo2Waveform = 0.0
    var lfo2Amplitude = 0.0
    var lfo2Rate = 0.0
    
    // Arp
    var arpDirection = 0.0
    var arpInterval = 12.0
    var arpOctave = 1.0
    var arpRate = 120.0
    var arpIsSequencer = false
    var arpTotalSteps = 7.0
    
    // Author
    var author = ""
    var category = 0
    var isUser = true
    var isFavorite = false
    
    // ******************************************************
    // MARK: - Init
    // ******************************************************
 
    init() {

     }

    convenience init(position: Int) {
        self.init()
        
        // Preset Number/Position
        self.position = position
        
        /*
        // Populate Sequence pattern with 16 steps
        for _ in 0...15 {
            let seqPattern = SeqPatternNote()
            seqPattern.seqNote = 0
            seqPatterns.append(seqPattern)
            
            let seqNoteOn = SeqNoteOn()
            seqNoteOn.noteOn = true
            seqNotesOn.append(seqNoteOn)
        }
        */
    }
    
    
    //*****************************************************************
    // MARK: - Class Function to Return array of Presets
    //*****************************************************************
    
    // Return Single Preset
    class public func parseDataToPresets(jsonArray: [Any]) -> [Preset] {
        var presets = [Preset]()
        for presetJSON in jsonArray {
            if let presetDictionary = presetJSON as? [String: Any] {
                let retrievedPreset = Preset(dictionary: presetDictionary)
                presets.append(retrievedPreset)
            }
        }
        return presets
    }
    
    // Return Single Preset
    class public func parseDataToPreset(presetJSON: Any) -> Preset {
        if let presetDictionary = presetJSON as? [String: Any] {
            return Preset(dictionary: presetDictionary)
        }
        return Preset()
    }
    
    //*****************************************************************
    // MARK: - JSON Parsing into object
    //*****************************************************************

    // Init from Dictionary/JSON
    init(dictionary: [String: Any]) {
        
        name = dictionary["name"] as? String ?? name
        position = dictionary["position"] as? Int ?? position
        
        // Synth VC
        octavePosition = dictionary["octavePosition"] as? Int ?? octavePosition
        isMono = dictionary["isMono"] as? Double ?? isMono
        isHoldMode = dictionary["isHoldMode"] as? Double ?? isHoldMode
        isArpMode = dictionary["isArpMode"] as? Double ?? isArpMode
        isTempoSyncd = dictionary["isTempoSyncd"] as? Double ?? isTempoSyncd
        
        // Controls VC
        masterVolume = dictionary["masterVolume"] as? Double ?? masterVolume
        seqPatternNote = dictionary["seqPatternNote"] as? [Int] ?? seqPatternNote
        seqNoteOn = dictionary["seqNoteOn"] as? [Bool] ?? seqNoteOn
        
        vco1Volume = dictionary["vco1Volume"] as? Double ?? vco1Volume
        vco2Volume = dictionary["vco2Volume"] as? Double ?? vco2Volume
        vco1Semitone = dictionary["vco1Semitone"] as? Double ?? vco1Semitone
        vco2Semitone = dictionary["vco2Semitone"] as? Double ?? vco2Semitone
        vco2Detuning = dictionary["vco2Detuning"] as? Double ?? vco2Detuning
        vcoBalance = dictionary["vcoBalance"] as? Double ?? vcoBalance
        subVolume = dictionary["subVolume"] as? Double ?? subVolume
        fmVolume = dictionary["fmVolume"] as? Double ?? fmVolume
        fmMod = dictionary["fmMod"] as? Double ?? fmMod
        noiseVolume = dictionary["noiseVolume"] as? Double ?? noiseVolume
       
        cutoff = dictionary["cutoff"] as? Double ?? cutoff
        rez = dictionary["rez"] as? Double ?? rez
        delayTime = dictionary["delayTime"] as? Double ?? delayTime
        delayFeedback = dictionary["delayFeedback"] as? Double ?? delayFeedback
        delayMix = dictionary["delayMix"] as? Double ?? delayMix
        reverbFeedback = dictionary["reverbFeedback"] as? Double ?? reverbFeedback
        reverbMix = dictionary["reverbMix"] as? Double ?? reverbMix
        reverbHighPass = dictionary["reverbHighPass"] as? Double ?? reverbHighPass
        midiBendRange = dictionary["midiBendRange"] as? Double ?? midiBendRange
        crushFreq = dictionary["crushFreq"] as? Double ?? crushFreq
        autoPanRate = dictionary["autoPanRate"] as? Double ?? autoPanRate
        filterADSRMix = dictionary["filterADSRMix"] as? Double ?? filterADSRMix
        glide = dictionary["glide"] as? Double ?? glide
        
        // ADSR
        attackDuration = dictionary["attackDuration"] as? Double ?? attackDuration
        decayDuration = dictionary["decayDuration"] as? Double ?? decayDuration
        sustainLevel = dictionary["sustainLevel"] as? Double ?? sustainLevel
        releaseDuration = dictionary["releaseDuration"] as? Double ?? releaseDuration
        
        filterAttack = dictionary["filterAttack"] as? Double ?? filterAttack
        filterDecay = dictionary["filterDecay"] as? Double ?? filterDecay
        filterSustain = dictionary["filterSustain"] as? Double ?? filterSustain
        filterRelease = dictionary["filterRelease"] as? Double ?? filterRelease
        
        // Toggle Presets
        delayToggled = dictionary["delayToggled"] as? Double ?? delayToggled
        reverbToggled = dictionary["reverbToggled"] as? Double ?? reverbToggled
        autoPanToggled = dictionary["autoPanToggled"] as? Double ?? autoPanToggled
        subOsc24Toggled = dictionary["subOsc24Toggled"] as? Double ?? subOsc24Toggled
        subOscSquareToggled = dictionary["subOscSquareToggled"] as? Double ?? subOscSquareToggled
        
        // Waveforms
        waveform1 = dictionary["waveform1"] as? Double ?? waveform1
        waveform2 = dictionary["waveform2"] as? Double ?? waveform2
        lfoWaveform = dictionary["lfoWaveform"] as? Double ?? lfoWaveform
        lfoAmplitude = dictionary["lfoAmplitude"] as? Double ?? lfoAmplitude
        lfoRate = dictionary["lfoRate"] as? Double ?? lfoRate
        lfo2Waveform = dictionary["lfo2Waveform"] as? Double ?? lfo2Waveform
        lfo2Amplitude = dictionary["lfo2Amplitude"] as? Double ?? lfo2Amplitude
        lfo2Rate = dictionary["lfo2Rate"] as? Double ?? lfo2Rate
        
        // Arp
        arpDirection = dictionary["arpDirection"] as? Double ?? arpDirection
        arpInterval = dictionary["arpInterval"] as? Double ?? arpInterval
        arpOctave = dictionary["arpOctave"] as? Double ?? arpOctave
        arpRate = dictionary["arpRate"] as? Double ?? arpRate
        arpIsSequencer = dictionary["arpIsSequencer"] as? Bool ?? arpIsSequencer
        arpTotalSteps = dictionary["arpTotalSteps"] as? Double ?? arpTotalSteps
        
        author = dictionary["author"] as? String ?? author
        category = dictionary["category"] as? Int ?? category
        isUser = dictionary["isUser"] as? Bool ?? isUser
        isFavorite = dictionary["isFavorite"] as? Bool ?? isFavorite
        
        // *** ToDo ***
        // LFO Routings
        // Tempo Sync
        // Filter Routing
        
        // *******************************
        // IMPORT
        // *******************************
        /*
        // Toggle Presets
        let delayToggledBool = dictionary["delayToggled"] as? Bool ?? false
        let reverbToggledBool = dictionary["reverbToggled"] as? Bool ?? true
        let autoPanToggledBool = dictionary["autoPanToggled"] as? Bool ?? false
        let subOsc24ToggledBool = dictionary["subOsc24Toggled"] as? Bool ?? false
        let subOscSquareToggledBool = dictionary["subOscSquareToggled"] as? Bool ?? false
        
        let vco1Toggled = dictionary["vco1Toggled"] as? Bool ?? true
        let vco2Toggled = dictionary["vco2Toggled"] as? Bool ?? true
        
        let verbHighPassToggledBool = dictionary["verbHighPassToggled"] as? Bool ?? false
       
        delayToggled = delayToggledBool ? 1.0 : 0.0
        reverbToggled = reverbToggledBool ? 1.0 : 0.0
        autoPanToggled = autoPanToggledBool ? 1.0 : 0.0
        subOsc24Toggled = subOsc24ToggledBool ? 1.0 : 0.0
        subOscSquareToggled = subOscSquareToggledBool ? 1.0 : 0.0
        vco1Volume = vco1Toggled ? 0.8 : 0.0
        vco2Volume = vco2Toggled ? 0.8 : 0.0
        reverbHighPass = verbHighPassToggledBool ? 700.0 : 10.0
        isMono = monoToggled ? 1.0 : 0.0
        isHoldMode = holdToggled ? 1.0 : 0.0
        isArpMode = arpToggled ? 1.0 : 0.0
        
        // Filter
        // Logarithmic scale: knobvalue to frequency
        cutoff = scaleRangeLog(cutoff, rangeMin: 30, rangeMax: 7000)
        */
        
        
    }
    
    func scaleRangeLog(_ value: Double, rangeMin: Double, rangeMax: Double) -> Double {
        let scale = (log(rangeMax) - log(rangeMin))
        return exp(log(rangeMin) + (scale * value))
    }
}
