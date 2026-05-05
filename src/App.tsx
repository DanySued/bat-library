import { Routes, Route, Navigate, useParams } from 'react-router-dom'
import { Landing } from './pages/Landing'
import { Library } from './pages/Library'
import { ToolDetail } from './pages/ToolDetail'
import { Saved } from './pages/Saved'

export default function App() {
  return (
    <Routes>
      <Route path="/" element={<Landing />} />
      <Route path="/bat" element={<Library />} />
      <Route path="/bat/:id" element={<ToolDetail />} />
      <Route path="/saved" element={<Saved />} />
      <Route path="/tool/:id" element={<LegacyToolRedirect />} />
    </Routes>
  )
}

function LegacyToolRedirect() {
  const { id } = useParams<{ id: string }>()
  return <Navigate to={`/bat/${id}`} replace />
}
