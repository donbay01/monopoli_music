const { onDocumentCreated } = require('firebase-functions/firestore')
const { streamedTrackPath } = require('../../constants/path')

exports.newTrackStream = onDocumentCreated(streamedTrackPath, (event) => {
    const snap = event.data

    return snap.ref.update({
        downloaded: false,
        liked: false,
        shared: false,
        playlists: []
    })
})