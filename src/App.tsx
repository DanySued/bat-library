import { Routes, Route, Navigate, useParams } from 'react-router-dom'
import { Landing } from './pages/Landing'
import { Library } from './pages/Library'
import { ToolDetail } from './pages/ToolDetail'
import { Saved } from './pages/Saved'
import { AuthProvider } from './contexts/AuthContext'
import { DownloadsProvider } from './contexts/DownloadsContext'
import { BookmarksProvider } from './contexts/BookmarksContext'
import { AuthModal } from './components/AuthModal'

export default function App() {
  return (
    <AuthProvider>
      <DownloadsProvider>
        <BookmarksProvider>
          <Routes>
            <Route path="/" element={<Landing />} />
            <Route path="/bat" element={<Library />} />
            <Route path="/bat/:id" element={<ToolDetail />} />
            <Route path="/saved" element={<Saved />} />
            <Route path="/tool/:id" element={<LegacyToolRedirect />} />
          </Routes>
          <AuthModal />
        </BookmarksProvider>
      </DownloadsProvider>
    </AuthProvider>
  )
}

function LegacyToolRedirect() {
  const { id } = useParams<{ id: string }>()
  return <Navigate to={`/bat/${id}`} replace />
}
