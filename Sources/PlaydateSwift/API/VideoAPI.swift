import CPlaydate

public class VideoAPI {
    public let api: playdate_video
    
    public init(api: playdate_video) {
        self.api = api
    }
    
    public func loadVideo(path: String) -> VideoPlayer {
        VideoPlayer(api.loadVideo(path))
    }
    
    public func freePlayer(_ player: VideoPlayer) {
        api.freePlayer(player.ptr)
    }
    
    public func setContext(_ player: VideoPlayer, to context: Image) throws {
        let result = api.setContext(player.ptr, context.ptr)
        if result == 0, let error = getError(player) {
            throw CError(err: error)
        }
    }
    
    public func getContext(_ player: VideoPlayer) -> Image {
        Image(api.getContext(player.ptr))
    }
    
    public func useScreenContext(_ player: VideoPlayer) {
        api.useScreenContext(player.ptr)
    }
    
    public func renderFrame(_ player: VideoPlayer, n: CInt) throws {
        let result = api.renderFrame(player.ptr, n)
        if result == 0, let error = getError(player) {
            throw CError(err: error)
        }
    }
    
    public func getError(_ player: VideoPlayer) -> String? {
        let cString = api.getError(player.ptr)
        return cString.map(String.init(cString:))
    }
    
    public func getInfo(_ player: VideoPlayer) -> (width: CInt, height: CInt, framerate: Float, frameCount: CInt, currentFrame: CInt) {
        var width: CInt = 0
        var height: CInt = 0
        var framerate: Float = 0
        var frameCount: CInt = 0
        var currentFrame: CInt = 0
        api.getInfo(player.ptr, &width, &height, &framerate, &frameCount, &currentFrame)
        return (width, height, framerate, frameCount, currentFrame)
    }
}
