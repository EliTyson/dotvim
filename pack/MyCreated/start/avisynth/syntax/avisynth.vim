" Vim syntax file
" Language:             Avisynth video scripting language
" Maintainer:           Eli Tyson
" Latest Revision:      2020-07-04

if exists("b:current_syntax")
    finish
endif

let b:current_syntax = "avisynth"

syntax keyword avisynthKeyword function global return try catch last
syntax keyword avisynthKeyword clip int float string bool val
highlight link avisynthKeyword Keyword

syntax match avisynthOperator "\v\<([=>])?"
syntax match avisynthOperator "\v\>(\=)?"
syntax match avisynthOperator "\v!(\=)?"
syntax match avisynthOperator "\v\=(\=)?"
syntax match avisynthOperator "\v\+(\+)?"
syntax match avisynthOperator "\v!(\=)?"
syntax match avisynthOperator "\v\="
syntax match avisynthOperator "\v\*"
syntax match avisynthOperator "\v/"
syntax match avisynthOperator "\v\%"
syntax match avisynthOperator "\v\-"
syntax match avisynthOperator "\v!"
syntax match avisynthOperator "\v\&\&"
syntax match avisynthOperator "\v\|\|"
syntax match avisynthOperator "\v\?"
syntax match avisynthOperator "\v:"
syntax match avisynthOperator "\v\."
highlight link avisynthOperator Operator

syntax match avisynthDelimiter "\v\,"
syntax match avisynthDelimiter "\v\("
syntax match avisynthDelimiter "\v\)"
syntax match avisynthDelimiter "\v\{"
syntax match avisynthDelimiter "\v\}"
syntax keyword avisynthDelimiter __END__
highlight link avisynthDelimiter Delimiter

" Non-Clip Internal Functions
" Boolean Functiion
syntax keyword avisynthFunction IsBool IsClip IsFloat IsInt IsString Exist Defined FunctionExists InternalFunctionExists VarExist
" Control Functions
syntax keyword avisynthFunction Apply Eval Import Select Default Assert NOP Undefined
" Global Options
syntax keyword avisynthFunction SetMemoryMax SetMaxCPU SetWorkingDir SetPlanarLegacyAlignment OPT_AllowFloatAudio OPT_UseWaveExtensible OPT_dwChannelMask OPT_AVIPadScanlines OPT_VDubPlanarHack OPT_Enable_V210 OPT_Enable_Y3_10_10 OPT_Enable_Y3_10_16 OPT_Enable_b64a OPT_Enable_PlanarToPackedRGB
" Conversion Functions
syntax keyword avisynthFunction Value HexValue Hex String
" Numeric Functions
syntax keyword avisynthFunction Max Min MulDiv Floor Ceil Round Int Float Fmod Pi Exp Log Log10 Pow Sqrt Abs Sign Frac Rand Spline ContinuedNumerator ContinuedDenominator
" Trigonometry Functions
syntax keyword avisynthFunction Sin Cos Tan Asin Acos Atan Atan2 Sinh Cosh Tanh
" Bit Functions
syntax keyword avisynthFunction BitAnd BitNot BitOr BitXor BitLSift Bitshl BitSal BitrShift BitRshiftS BitSar BitRShiftL BitRShiftU BitShr BitLRotate BitRol BitRRotateL BitRor BitTest BitTst BitSet BitSetCount BitClear BitClr BitChange BitChg
" Runtime Functions
syntax keyword avisynthFunction AverageLuma AverageChromaU AverageChromaV AverageB AverageG AverageR
" Scripting Functions
syntax keyword avisynthFunction LumaDifference ChromaUDifference ChromaVDifference RGBDifference BDifference GDifference RDifference
syntax keyword avisynthFunction YDifferenceFromPrevious UDifferenceFromPrevious VDifferenceFromPrevious RGBDifferenceFromPrevious BDifferenceFromPrevious GDifferenceFromPrevious RDifferenceFromPrevious
syntax keyword avisynthFunction YPlaneMedian UPlaneMedian VPlaneMedian BPlaneMedian GPlaneMedian RPlaneMedianYPlaneMin UPlaneMin VPlaneMin BPlaneMin GPlaneMin RPlaneMinYPlaneMax UPlaneMax VPlaneMax BPlaneMax GPlaneMax RPlaneMax YPlaneMinMaxDifference UPlaneMinMaxDifference VPlaneMinMaxDifference BPlaneMinMaxDifference GPlaneMinMaxDifference RPlaneMinMaxDifference
syntax keyword avisynthFunction ScriptName ScriptNameUtf8 ScriptFile ScriptFileUtf8 ScriptDir ScriptDirUtf8 SetLogParams LogMsg GetProcessInfo
" String Functions
syntax keyword avisynthFunction LCase UCase StrToUtf8 StrFromUtf8 StrLen RevStr LeftStr RightStr MidStr FindStr ReplaceStr Format FillStr StrCmp StrCmpi TrimLeft TrimRight TrimAll Chr Ord Time
" Version Functions
syntax keyword avisynthFunction VersionNumber VersionString IsVersionOrGreater
" Other Helper Functions
syntax keyword avisynthFunction BuildPixelType ColorSpaceNameToPixelType

" Internal Filters (Internal Clip Functions)
" Source Filters
syntax keyword avisynthFunction AviSource AviFileSource OpenDMLSource DirectShowSource ImageReader ImageSource ImageSourceAnim Import SegmentedAviSource SegmentedDirectShowSource WavSource
" Color Conversion & Adjustment Filters
syntax keyword avisynthFunction ColorYUV ConvertBackToYUY2 ConvertToRGB ConvertToRGB24 ConvertToRGB32 ConvertToRGB48 ConvertToRGB64 ConvertToPlanarRGB ConvertToPlanarRGBA ConvertToYUY2 ConvertToYV24 ConvertToYV16 ConvertToYV12 ConvertToY8 ConvertToYUV444 ConvertToYUV422 ConvertToYUV420 ConvertToYUVA444 ConvertToYUVA422 ConvertToYUVA420 ConvertToYUV411 FixLuminance Greyscale Grayscale Invert Levels Limiter MergeRGB MergeARGB MergeLuma MergeChroma RGBAdjust ShowRed ShowGreen ShowBlue ShowAlpha SwapUV Tweak UToY UToY8 VToY VToY8 YToUV
" Overlay and Mask Filters
syntax keyword avisynthFunction ColorKeyMask Layer Mask MaskHS Merge Overlay ResetMask Subtract
" Geometric Deformation Filters
syntax keyword avisynthFunction AddBorders Crop CropBottom FlipHorizontal FlipVertical Letterbox HorizontalReduceBy2 VerticalReduceBy2 ReduceBy2 BicubicResize BilinearResize BlackmanResize GaussResize LanczosResize Lanczos4Resize PointResize SincResize Spline16Resize Spline36Resize Spline64Resize SkewRows TurnLeft TurnRight Turn180
" Pixel Restoration Filters
syntax keyword avisynthFunction Blur Sharpen GeneralConvolution SpatialSoften TemporalSoften FixBrokenChromaUpsampling
" Time Editing Filters
syntax keyword avisynthFunction AlignedSplice UnalignedSplice AssumeFPS AssumeScaledFPS ChangeFPS ConvertFPS DeleteFrame Dissolve DuplicateFrame FadeIn0 FadeIn FadeIn2 FadeOut0 FadeOut FadeOut2 FadeIO0 FadeIO FadeIO2 FreezeFrame Interleave Loop Reverse SelectEven SelectOdd SelectEvery SelectRangeEvery Trim
" Interlace Filters
syntax keyword avisynthFunction AssumeFrameBased AssumeFieldBased AssumeBFF AssumeTFF Bob ComplementParity DoubleWeave PeculiarBlend Pulldown SeparateColumns SeparateRows SeparateFields SwapFields Weave WeaveColumns WeaveRows
" Audio Processing Filters
syntax keyword avisynthFunction Amplify AmplifydB AssumeSampleRate AudioDub AudioDubEx AudioTrim ConvertAudioTo8bit ConvertAudioTo16bit ConvertAudioTo24bit ConvertAudioTo32bit ConvertAudioToFloat ConvertToMono DelayAudio EnsureVBRMP3Sync GetChannel GetLeftChannel GetRightChannel KillAudio KillVideo MergeChannels MixAudio MonoToStereo Normalize ResampleAudio SuperEQ SSRC TimeStretch
" Conditional & Other Meta Filters
syntax keyword avisynthFunction ConditionalFilter FrameEvaluate ScriptClip ConditionalSelect ConditionalReader WriteFile WriteFileIf WriteFileStart WriteFileEnd Animate ApplyRange TCPServer TCPSource
" Export Filters
syntax keyword avisynthFunction ImageWriter
" Debug Filters
syntax keyword avisynthFunction BlankClip Blackness ColorBars ColorBarsHD Compare Echo Histogram Info MessageClip Preroll ShowFiveVersions ShowFrameNumber ShowSMPTE ShowTime StackHorizontal StackVertical Subtitle Tone Version

" Plugins
syntax keyword avisynthFunction LoadPlugin LoadCPlugin LoadVirtualDubPlugin LoadVFAPIPlugin

" External Filters (Small Subset)
syntax keyword avisynthFunction ColorMatrix QTInput DSS2 FVideoSource FFAudioSource FFIndexSource FFImageSource FFmpegSource2 FFMS2 LSmashSource2 LibavSource2 LSMASHVideoSource LWLibavVideoSource LSMASHAudioSource LWLibavAudioSource NicAC3Source NicDTSSource NicMPG123Source NicLPCMSource RaWavSource VSFilter DGDecode SoundOut SoxFilter FDecimate FDecimate2 TransAll WaveForm FixChromaBleeding QTGMC Yadif Decomb

highlight link avisynthFunction Function

" Clip Properties
syntax keyword avisynthPorperties HasAudio HasVideo
" Video Properties
syntax keyword avisynthPorperties Width Height FrameCount FrameRate FrameRateNumerator FrameRateDenominator IsFieldBased IsFrameBased GetParity PixelType IsPlanar IsInterleaved IsRGB IsRGB24 IsRGB32 IsYUV IsYUV IsYUY2 IsY8 IsYV12 IsYV16 IsYV24 IsYV411 Is420 Is422 Is422 Is444 IsY IsYUVA IsRGB48 IsRGB64 IsPackedRGB IsPlanarRGB IsPlanarRGBA HasAlha ComponentSize NumComponents BitsPerComponent
"Audio Properties
syntax keyword avisynthPorperties AudioRate AudioDuration AudioLength AudioLengthF AudioLengthS AudioLengthLo AudioLengthHi AudioChannels AudioBits IsAudioFloat IsAudioInt
highlight link avisynthProperties Structure

syntax match avisynthNumber "\v([+-])?(\k)@<!\d+(\.\d+)?"
syntax match avisynthNumber "\v\$\x+"
highlight link avisynthNumber Number

syntax keyword avisynthBoolean true false yes no True False Yes No TRUE FALSE YES NO
highlight link avisynthBoolean Boolean

syntax region avisynthString start=/\v"/ skip=/\v\\./ end=/\v"/
highlight link avisynthString String

syntax match avisynthComment '\v#.*$'
syntax match avisynthComment '\v\/\*\_.{-}\*\/'
syntax match avisynthComment '\[\*\_.*\*\]'
highlight link avisynthComment Comment
